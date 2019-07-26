sampler2D inputTex : register(s0);
float4 paint(float2 texCoord) {
float4 result = tex2D(inputTex, texCoord);
return result;
}
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
color = paint(pos0) * jsl_vertexColor;
if (color.a == 0.0)discard;}
