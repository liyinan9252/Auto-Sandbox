         /*-------------- BUILDS --------------*/


     /*----- "Brute Force" using Ivanyos-Qiao technique -----*/

// Construct a full rank matrix from K^d1 to K^d2  
__get_full_rank := function(K, d1, d2)
  I := IdentityMatrix(K, Minimum(d1, d2));
  if d1 ge d2 then
    M := VerticalJoin(I, ZeroMatrix(K, d1 - d2, d2));
  else
    M := HorizontalJoin(I, ZeroMatrix(K, d1, d2 - d1));
  end if;
  // '@' does not work with general Mtrx. This fixes that issue.
  return Hom(RSpace(K, d1), RSpace(K, d2))!M;
end function;

// get the function E by pre-composing t with the maps in M on coords A 
__get_eval_map := function(t, M, A)
  E := function(x)
    y := x;
    for i in [1..#x] do
      if #x-i in A then
        y[i] := x[i] @ M[i];
      end if;
    end for;
    if 0 notin A then
      return y @ t @ M[#M];
    else
      return y @ t;
    end if;
  end function;

  return E;
end function;

  /*
    Notes from JM: 

    Assumption is that f is "almost" a homotopism from t1 to t2. That is,
      t1 : U_v x ... x U_1 >-> U_0
           |           |       | 
      t2 : V_v x ... x V_1 >-> V_0,
    where the underlying tensor category of f places an orientation of the 
    edges above. 

    If a != 0, then we apply a shuffle to both t1 and t2, call them s1 and s2 
    respectively. We also need to apply the same permutation to f, call it g. 

    Now we need to define two more tensors, we will call them s1_g and s2_g. We
    define them based on g, and before we describe that, let me say a word about 
    arrow orientation. Running Arrows(TensorCategory(g)) will return a sequence
    in {-1, 1}. We assume 1 forces the arrow to point down, i.e. 
      g_a : U_a -> V_a
    and a -1 forces the arrow to point up:
      g_b : V_b -> U_b.
    Define a partition of {1, ..., v} as follows. Let A be the set of 
    coordinates whose arrows point up and B the arrows that point down. We have 
    a slight variation of this in the code, where the partition includes the 0.

    The two tensors we define will have the frame
      prod_{a in A} V_a x prod_{b in B} U_b  >->  C,
    where the domain is ordered properly, not necessarily grouped up in A and B,
    and C is U_0 if the last arrow is pointing up or V_0 if pointing down. 

    Now we build the corresponding (co)tensor spaces spanned by the mulitilinear
    forms. Like in previous builds, we check if they span the same subspace. If
    they do, then we can construct a lift: simply write the basis of one 
    subspace in terms of the other. If they do not span the same subspace, then 
    no such lift can be constructed. 
  */

// Input: s1::TenSpcElt, s2::TenSpcElt, g::Hmtp
// Output: BoolElt, Hmtp
__Lift_0_Coordinate := function(s1, s2, g)
  // initial setup
  K := BaseRing(s1);
  v := Valence(s1);
  M := Maps(g);

  // put the frames side-by-side
  F_zip := [*<Frame(s1)[i], Frame(s2)[i]> : i in [1..v]*];

  // map from {0, ..., v-1} to {-1, 1} giving arrow orientation
  Arr_map := TensorCategory(g)`Arrows;

  // map interpreting the output of Arr_map based on F_zip
  FindDom := map< {1,-1} -> {1,2} | [<1, 1>, <-1, 2>] >;

  // get partitions
  A := {a : a in {0..v-1} | a @ TensorCategory(g)`Arrows eq -1};
  B := {0..v-1} diff A;

  // put the final map in the list of mats
  if 0 in A then
    M[v] := __get_full_rank(K, Dimension(F_zip[v][1]), Dimension(F_zip[v][2]));
  else 
    M[v] := __get_full_rank(K, Dimension(F_zip[v][2]), Dimension(F_zip[v][1]));
  end if;

  // select the spaces described above
  // note the minus sign for the 0 coordinate!
  Fr := [*F_zip[i][(v - i) @ Arr_map @ FindDom] : i in [1..v-1]*] cat 
      [*F_zip[v][(-(0 @ Arr_map)) @ FindDom]*];
  
  // the maps
  eval1 := __get_eval_map(s1, M, A);
  eval2 := __get_eval_map(s2, M, B);
  
  // construct the tensors with all the data
  s1_g := Tensor(Fr, eval1, TensorCategory(g));
  s2_g := Tensor(Fr, eval2, TensorCategory(g));

  // construct the corresponding cotensor spaces
  S1 := AsCotensorSpace(s1_g)`Mod;
  S2 := AsCotensorSpace(s2_g)`Mod;

  // decide if we can lift
  if S1 ne S2 then
    return false, _;
  end if;

  // replace the dummy map with the correct map
  if 0 in A then
    M0 := Transpose(Matrix([Coordinates(S2, b) : b in Basis(S1)]));
  else
    M0 := Transpose(Matrix([Coordinates(S1, b) : b in Basis(S2)]));
  end if;
  M[v] := M0;

  // use pre-built machinery to build and verify
  check, H := IsHomotopism(s1, s2, M, TensorCategory(g));
  assert check;

  return true, H;
end function;


/*
  Input:
    (1) tensors t1 and t2 having compatible frames
    (2) f, an invertible map from the frame of t1 to the frame of t2;
        we further assume this map is passed as an isotopism between
        the 0-tensors on the given frames
    (3) a, an integer specifying a coordinate of the frames
  Output:
    (1) true if, and only if, f can modified to an isotopism g from t1
        to t2 by changing just the a-th coordinate
    (2) such an isotopism g 
*/
/*
  Lift 1 is now part of TensorSpace. I commented this out because it was 
  overwriting the version in TensorSpace. -- JM  28.02.2019.

intrinsic Lift1 (t1::TenSpcElt, t2::TenSpcElt, f::Hmtp, a::RngIntElt) 
    -> BoolElt, Hmtp
    
  {Given tensors t1 and t2, a transformation f between their frames, and
   a particular coordinate a, find a modification g of f in this single coordinate 
   so that g is an isotopism from t1 to t2.}

  // some checks to prevent garbage
  require Valence(t1) eq Valence(t2) : "Tensors do not have the same valence.";
  require a in {0..Valence(t1)-1} : "Unknown coordinate.";
  C1 := TensorCategory(t1);
  C2 := TensorCategory(t2);
  require {a} in RepeatPartition(C1) : "Given coordinate is fused.";
  require {a} in RepeatPartition(C2) : "Given coordinate is fused.";

  // construct a permutation
  v := Valence(t1);
  G := Sym({0..v-1});
  if a ne 0 then
    perm := G!(0, a);
  else
    perm := G!1;
  end if;

  // permute all the data
  s1 := Shuffle(t1, perm);
  s2 := Shuffle(t2, perm);
  g := Shuffle(f, perm);

  // run the magic
  check, H_shuf := __Lift_0_Coordinate(s1, s2, g);

  // interpret the output
  if not check then
    return false, _;
  end if;

  // Shuffle back
  H := Shuffle(H_shuf, perm^-1);
  another_check, H := IsHomotopism(t1, t2, Maps(H), TensorCategory(H));
  assert another_check;

  return true, H;
*/
/*
  Now old: delete once we're content. --JM    03.02.2019

  v := Valence(t1);
  // insert the identity map into component a of f, building this as a 
  // homotopism between 0 tensors
  M := Maps (f);
  da := Dimension (Frame (t1)[v - a]);
  M[v - a] := IdentityMatrix (BaseRing (t1), da);
  fa := Homotopism (M, HomotopismCategory (Valence (t1)));
  
  // Need our homotopism to be cohomotopism with all but last arrow pointing 
  // INTO frame of t1. Thus, we must invert all but the last coordinate.
  M_chmtp := [*X^-1 : X in M[1..v-1]*] cat [*M[v]*];
  repeats := RepeatPartition(TensorCategory(f));
  Cat := TensorCategory([-1 : i in [1..v-1]] cat [1], repeats);
  fa_chmtp := Homotopism(M_chmtp, Cat);

  // now apply this "homotopism" to t1 ... 
  // I'm also unsure as to whether it's t1 or t2, but ...
  s := t1 @ fa_chmtp;
  
  // test whether the "a-slices" are equal
  Sa := AsCotensorSpace (s);
  T2a := AsCotensorSpace (t2);
  if Sa ne T2a then
       return false, _;
  end if;
  
  // compute the map in the a-th coordinate
  USa := Sa`Mod;
  UT2a := T2a`Mod;   
  Ma := Matrix ([ Coordinates (UT2a, USa.i) : i in [1..da] ]);
  // note: there was a transpose on this matrix in the system of forms version
  // also: is this map in the right direction? if not, we can invert
  
  // something like ...
  if a ne 0 then
       M[v - a] := Ma;
  else
       M[v - a] := Ma^-1;
  end if;
  g := Homotopism (t1, t2, M);   // my understanding is that this checks automatically

return true, g;
   */
//end intrinsic;


/*
  Input:
    (1) tensors t1 and t2 having compatible frames
    (2) f, an invertible map from the frame of t1 to the frame of t2;
        we further assume this map is passed as an isotopism between
        the 0-tensors on the given frames
    (3) a, b integers specifying coordinates of the frames
  Output:
    (1) true if, and only if, f can modified to an isotopism g from t1
        to t2 by changing just the a- and b-coordinates
    (2) such an isotopism g 
  REMARK: this function uses Ivanyos-Qiao and the version for non-symmetrized
    bimaps by Brooksbank-Wilson.
*/
intrinsic Lift2 (t1::TenSpcElt, t2::TenSpcElt, f::Hmtp, a::RngIntElt, b::RngIntElt) 
    -> BoolElt, Hmtp
    
  {Given tensors t1 and t2, a transformation f between their frames, and
   two coordinates a and b, find a modification g of f in these coordinates so
   that g is an isotopism from t1 to t2.}
  
// NEED TO DISCUSS THIS ONE.

//return true, g;
   
end intrinsic;


  
/*
  Input: a tensor, t
  Output: the group of autotopisms of t
  
  This will work most effectively for 3-tensors (bimaps), since the method
  uses Lift2 to work exhaustively through all possible invertible transformations
  on all but 2 of the frame coordinates.
*/
intrinsic AutotopismGroupIQ (t::TenSpcElt) -> GrpMat
  
  {Compute the autotopism group of the tensor t by working through all potential
   maps using Lift2.}
   
end intrinsic;


intrinsic IsIsotopicIQ (t1::TenSpcElt, t2::TenSpcElt) -> BoolElt, Hmp, GrpMat
  
  {Compute the coset of isotopisms from t1 to t2 by working through all potential
   maps using Lift2.}
   
end intrinsic;


         /*----- Adjoint-Tensor methods -----*/

// LOOK AT THE DOCS FOR eMAGma ... THERE'S A TENSOR OVER NUCLEUS FUNCTION WE CAN USE.
/*
  Input: a 3-tensor (bimap), t
  Output: the group of autotopisms of t, obtained by forming the tensor over the
    adjoint algebra (middle nucleus) of t and carrying out orbit-stabilizer in that
    space. 
  REMARK: this method requires the normalizer of an algebra and (for symmetrized
    tensors) the normalizer of a *-algebra.
*/
intrinsic AutotopismGroupAT (t::TenSpcElt) -> GrpMat

  {Given a 3-tensor (bimap), t, use the adjoint-tensor method to compute
   the group of autotopisms of t.}
   
   require Valence (t) eq 3 : "t must be a 3-tensor (bimap) for this method";
   
end intrinsic;


intrinsic IsIsotopicAT (t1::TenSpcElt, t2::TenSpcElt) -> BoolElt, Hmtp, GrpMat

  {Given a 3-tensors (bimap), t1 and t2, use the adjoint-tensor method to compute
   the coset of isotopisms from t1 to t2.}
   
end intrinsic;

// similar functions for derivation-densor

