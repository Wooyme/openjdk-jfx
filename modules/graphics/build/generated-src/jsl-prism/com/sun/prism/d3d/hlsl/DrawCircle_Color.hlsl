float2 idim : register(c0);
float mask(float2 tco, float2 odim) {
float lensq_m_25 = dot(tco, tco) - 0.25;
float ocov = clamp(0.5 * (odim.x + 1.0 - lensq_m_25 / odim.x), 0.0, odim.y);
float icov = clamp(0.5 * (idim.x + 1.0 - lensq_m_25 / idim.x), 0.0, idim.y);
return ocov - icov;
}
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
color = mask(pos0, pos1) * jsl_vertexColor;
}
