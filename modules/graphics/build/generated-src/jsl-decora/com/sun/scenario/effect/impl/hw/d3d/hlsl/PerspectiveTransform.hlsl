sampler2D baseImg : register(s0);
float3 tx0 : register(c0);
float3 tx1 : register(c1);
float3 tx2 : register(c2);
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
float3 p1;
float3 p2;
p1 = float3(pos0.x, pos0.y, 1.0);
p2.z = dot(p1, tx2);
p2.x = dot(p1, tx0) / p2.z;
p2.y = dot(p1, tx1) / p2.z;
color = tex2D(baseImg, p2.xy);
}
