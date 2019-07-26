sampler2D imageTex : register(s0);
sampler2D maskTex : register(s1);
float4 paint(float2 imgCoord, float2 maskCoord) {
return tex2D(imageTex, imgCoord) * tex2D(maskTex, maskCoord).a;
}
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
color = paint(pos0, pos1) * jsl_vertexColor;
if (color.a == 0.0)discard;}
