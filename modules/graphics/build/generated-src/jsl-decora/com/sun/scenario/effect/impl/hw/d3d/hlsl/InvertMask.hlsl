sampler2D baseImg : register(s0);
float2 offset : register(c0);
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
float val = tex2D(baseImg, pos0 - offset).a;
float inv = 1.0 - val;
color = float4(inv, inv, inv, inv);
}
