float mask(float2 tco, float2 dim) {
float lensq = dot(tco, tco);
return clamp(0.5 * (dim.x + 1.0 - (lensq - 0.25) / dim.x), 0.0, dim.y);
}
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
color = mask(pos0, pos1) * jsl_vertexColor;
}
