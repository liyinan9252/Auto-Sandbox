freeze;

import "misc.m": VectorToInt, DefiningParameters, MypCentralSeries;
import "autos.m": ActionOnFactor;
import "canonical.m": PInvariantFlag;
import "parameters.m": RF;

/* convert flag to new basis for subgroup of K generated by gens */

FlagToBasis := function (K, Flag, gens)
   basis := [];
   k := #gens;
   for j in [1..#Flag] do
      w := VectorToInt (Flag[j]);
      basis[j] := &*[gens[i]^w[i]: i in [1..#w] | w[i] gt 0];
   end for;

   return basis;
end function;

/* new basis for level of plcs of K, corresponding to flag for action
   of p-subgroup of Auts on this level */
FlagBasis := function (K, Auts, top, bottom, gens)
   p := DefiningParameters (K);
   mats := ActionOnFactor (K, top, bottom, Auts);
   q := NPCgens (top) - NPCgens (bottom);
   V := VectorSpace (GF (p), q);
   G := sub < GL(q, p) | mats >;

   Flag, CB, VS := PInvariantFlag (V, G);

   return FlagToBasis (K, Flag, gens), VS, Flag, CB;
end function;

/* Z are central generators of K modulo M where M is last class of K;
   form (z, b) for b in B, a basis for Frattini quotient of K,
   and collect exponents of generators of M wrt basis specified
   by CB as matrix;

   if B has rank d and M has rank t, the resulting matrix has
   d * t columns, each corresponding to one of the d * t central
   autos; we are echelonising wrt a chosen decreasing central series
   where the *last* column corresponds to an element of the
   centre of the aut subgroup;

   in the resulting echelonised matrix, if column i has a leading term,
   then the corresponding auto (having number d * t - i + 1) is redundant */
CentralMatrix := function (K, M, CB, Z, B)
   p, d := DefiningParameters (K);
   V := VectorSpace (GF (p), NPCgens (M));

   MA := KMatrixSpace (GF (p), #Z, #B * NPCgens (M));
   A := Zero (MA);

   offset := #(B);
   for i in [1..#Z] do
      for j in [1..#B] do
         g := (Z[i], B[j]);
         e := VectorToInt ((V ! Eltseq (M!g)) * CB);
         for k in [1..#e] do
            if e[k] gt 0 then
               A[i][offset * (k - 1) + j] := e[k];
            end if;
         end for;
      end for;
   end for;

//   vprint AutomorphismGroup, 2:
//      "Unechelonized central automorphism matrix: ", A;

   return EchelonForm (A);
end function;

/* B and M are generating sets corresponding to flags
   for K/Phi(K) and last plcs section of K;
   which central automorphisms can be obtained from
   inner automorphisms? */
RedundantCentrals := function (K, Auts, B, M: Flag := true)
   p := FactoredOrder (K)[1][1];
   r := [0] cat pRanks (K);
   c := #r - 1;
   LCS := pCentralSeries (K, p);

   /* determine centre of quotient of K / M */
   H, phi := quo < K | LCS[c]>;
   ZH := Centre (H);
   Z := [K!(ZH.i @@ phi): i in [1..NPCgens (ZH)]];

   if Flag then
      /* supply new generators for Msub and determine change of basis
         from Magma chosen generating set to supplied M */
      Msub, tau := sub < K | M >;
      CB := &cat[Eltseq (M[i] @@ tau): i in [1..#M]];
      CB := GL (#M, p) ! CB;
      CB := CB^-1;
   else
      B := [K.i : i in [1..r[2]]];
      M := [K.i : i in [r[c] + 1..r[#r]]];
      Msub := sub < K | M >;
      CB := Identity (GL (#M, p));
   end if;

   A := CentralMatrix (K, Msub, CB, Z, Reverse (B));
//   vprint AutomorphismGroup, 2: "Echelonised central automorphism matrix: ", A;

   redundant := {Ncols (A) + 1 - Depth (A[i]):  i in [1..Nrows (A)]};
   return redundant, A;
end function;

/* U represents ascending flag for action on Frattini quotient of K;
   V represents descending flag for action on last section of K;
   construct central series gamma for elementary abelian group;

   let gamma_ij be those automorphisms whose kernel
   contains U_{i+1} and whose image contains V_j; then

   gamma_1,1 < gamma_2,1 < ... < gamma_t,1 < gamma_1,2 < ..< gamma_t,2
            < .. < gamma_t,s

   is an ascending central series for central autos */
JointFlags := function (U, V)
   Uspace := U[1];
   Vspace := V[1];
   t  := #U;
   s := #V;
   Reverse (~V);

   gamma := [];
   for j in [1..s - 1] do
      right, tau := quo <V[j + 1] | V[j]>;
      b := Basis (right);
      right := VectorToInt (Vspace!(b[1] @@ tau));
      for i in [1..t - 1] do
         left, phi := quo <U[i] | U[i + 1]>;
         b := Basis (left);
         left := VectorToInt (Uspace!(b[1] @@ phi));
         Append (~gamma, <left, right>);
      end for;
   end for;

   return gamma;
end function;

/* construct a chief series through the central automorphisms of K */
ChiefSeriesThroughCentrals := function (K, Auts)
   p, d := DefiningParameters (K);
   c := pClass (K);
   p := FactoredOrder (K)[1][1];
   r := [0] cat pRanks (K);

   LCS := pCentralSeries (K, p);

   gens := [K.i : i in [r[1] + 1..r[2]]];
   B, U := FlagBasis (K, Auts, LCS[1], LCS[2], gens);
   assert #B eq d;
   gens := [K.i : i in [r[c] + 1..r[c + 1]]];
   M, V := FlagBasis (K, Auts, LCS[c], LCS[c + 1], gens);
   q := #M;

   Gamma := JointFlags (U, V);

   offset := r[#r - 1];

   /* Horror -- Magma may rewrite the basis for each flag;
      set up the two *decreasing* flags used in JointFlags */

   B := []; M := [];
   for l in [1..d] do
      left := Gamma[l][1];
      B[l] := &*[K.m^left[m] : m in [1..d]];
   end for;
   for l in [1..q] do
      right := Gamma[(l - 1) * d + 1][2];
      M[l] := &*[K.(offset + m)^right[m] : m in [1..q]];
   end for;
   Reverse (~M);

   /* central series through autos */
   Im := [];
   for l in [1..#Gamma] do
      left := Gamma[l][1]; right := Gamma[l][2];
      dom := &*[K.m^left[m] : m in [1..d]];
      im := &*[K.(offset + m)^right[m] : m in [1..q]];
      Append (~Im, <dom, im>);
   end for;

   return Im, B, M;
end function;

/* return descending chief series for central automorphisms of K
   in group generated by Auts + these centrals; we first elimate those
   centrals which can be obtained from inners + remaining centrals */
CentralAutomorphisms := function (K, Auts)
   p, d := DefiningParameters (K);
   C, B, M := ChiefSeriesThroughCentrals (K, Auts);

   R := RedundantCentrals (K, Auts, B, M: Flag := true);
   vprint AutomorphismGroup, 2: "Redundant central automorphisms: ", R;

   pAuts := [];
   for i in [1..#C] do
      if i in R then continue; end if;
      left := C[i][1];
      right := C[i][2];
      id := [<B[l], B[l]> : l in [1..d] | B[l] ne left];
      images := id cat [<left, left * right>];
      alpha := hom <K -> K | images : Check := false>;
      Append (~pAuts, rec<RF | map := alpha, type := "p-automorphism">);
   end for;

   Reverse (~pAuts);
   return pAuts;
end function;
