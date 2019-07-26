float mask(float2 tco, float2 tcc) {
float2 cov = clamp(tcc + 0.5 - abs(tco), 0.0, 1.0);
cov = min(cov, tcc * 2.0);
return cov.x * cov.y;
}
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
color = mask(pos0, pos1) * jsl_vertexColor;
if (color.a == 0.0)discard;}
