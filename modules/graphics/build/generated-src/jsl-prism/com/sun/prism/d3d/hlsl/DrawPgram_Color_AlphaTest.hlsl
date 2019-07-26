float2 idim : register(c0);
float mask(float2 tco, float2 odim) {
float2 ocov = clamp(odim + 0.5 - abs(tco), 0.0, 1.0);
float2 icov = clamp(idim + 0.5 - abs(tco), 0.0, 1.0);
ocov = min(ocov, odim * 2.0);
icov = min(icov, idim * 2.0);
return ocov.x * ocov.y - icov.x * icov.y;
}
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
color = mask(pos0, pos1) * jsl_vertexColor;
if (color.a == 0.0)discard;}
