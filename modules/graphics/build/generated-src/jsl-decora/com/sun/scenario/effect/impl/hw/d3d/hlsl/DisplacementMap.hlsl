sampler2D origImg : register(s0);
sampler2D mapImg : register(s1);
float4 sampletx : register(c0);
float4 imagetx : register(c1);
float wrap : register(c2);
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
float4 off = tex2D(mapImg, pos1);
float2 loc = pos0 + sampletx.zw * (off.xy + sampletx.xy);
loc -= wrap * floor(loc);
loc = imagetx.xy + (loc * imagetx.zw);
color = tex2D(origImg, loc);
}
