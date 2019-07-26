sampler2D maskInput : register(s0);
float mask(float2 texCoord) {
return tex2D(maskInput, texCoord).a;
}
sampler2D colors : register(s1);
float4 content : register(c0);
float3 precalc : register(c1);
float4 paint(float2 texCoord) {
float xfx = texCoord.x - precalc.x;
float dist = (precalc.x * xfx + sqrt(xfx * xfx + texCoord.y * texCoord.y * precalc.y)) * precalc.z;
float2 fractvals = float2(frac(dist), clamp(dist, 0.0, 1.0));
float2 clrCoord = float2(content.x + dot(fractvals, content.zw), content.y);
return tex2D(colors, clrCoord);
}
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
color = mask(pos0) * paint(pos1) * jsl_vertexColor;
if (color.a == 0.0)discard;}
