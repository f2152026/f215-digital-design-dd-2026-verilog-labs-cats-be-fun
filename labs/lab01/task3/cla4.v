// cla4.v
// Gate-level 4-bit carry-lookahead adder, matching the lecture circuit.
// Every gate has an explicit constant delay of #(2).

module cla4(
  input  [3:0] a,
  input  [3:0] b,
  input        cin,
  output [3:0] sum,
  output       cout
);

  wire p0, p1, p2, p3;
  wire g0, g1, g2, g3;
  wire c1, c2, c3;

  // Step 1: generate/propagate signals
  xor #(2) (p0, a[0], b[0]);
  xor #(2) (p1, a[1], b[1]);
  xor #(2) (p2, a[2], b[2]);
  xor #(2) (p3, a[3], b[3]);

  and #(2) (g0, a[0], b[0]);
  and #(2) (g1, a[1], b[1]);
  and #(2) (g2, a[2], b[2]);
  and #(2) (g3, a[3], b[3]);

  // Step 2: direct carry equations
  wire t1_1;
  and #(2) (t1_1, p0, cin);
  or  #(2) (c1, g0, t1_1);

  wire t2_1, t2_2;
  and #(2) (t2_1, p1, g0);
  and #(2) (t2_2, p1, p0, cin);
  or  #(2) (c2, g1, t2_1, t2_2);

  wire t3_1, t3_2, t3_3;
  and #(2) (t3_1, p2, g1);
  and #(2) (t3_2, p2, p1, g0);
  and #(2) (t3_3, p2, p1, p0, cin);
  or  #(2) (c3, g2, t3_1, t3_2, t3_3);

  wire t4_1, t4_2, t4_3, t4_4;
  and #(2) (t4_1, p3, g2);
  and #(2) (t4_2, p3, p2, g1);
  and #(2) (t4_3, p3, p2, p1, g0);
  and #(2) (t4_4, p3, p2, p1, p0, cin);
  or  #(2) (cout, g3, t4_1, t4_2, t4_3, t4_4);

  // Step 3: sum bits
  xor #(2) (sum[0], p0, cin);
  xor #(2) (sum[1], p1, c1);
  xor #(2) (sum[2], p2, c2);
  xor #(2) (sum[3], p3, c3);

endmodule