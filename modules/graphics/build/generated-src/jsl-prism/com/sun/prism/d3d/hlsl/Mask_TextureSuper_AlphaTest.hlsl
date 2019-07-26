sampler2D inputTex0 : register(s0);
sampler2D inputTex1 : register(s1);
float4 paint(float2 texCoord0, float2 texCoord1) {
return (tex2D(inputTex0, texCoord0) * texCoord1.x) + (tex2D(inputTex1, texCoord0).a * texCoord1.y);
}
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
color = paint(pos0, pos1) * jsl_vertexColor;
if (color.a == 0.0)discard;}
