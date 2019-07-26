sampler2D maskInput : register(s0);
float2 innerOffset : register(c0);
float mask(float2 texCoord) {
return tex2D(maskInput, texCoord).a - tex2D(maskInput, texCoord - innerOffset).a;
}
sampler2D inputTex : register(s1);
float4 content : register(c1);
float4 paint(float2 texCoord) {
texCoord = frac(texCoord);
texCoord = float2(content.x, content.y) + texCoord * float2(content.z, content.w);
return tex2D(inputTex, texCoord);
}
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
color = mask(pos0) * paint(pos1) * jsl_vertexColor;
if (color.a == 0.0)discard;}
