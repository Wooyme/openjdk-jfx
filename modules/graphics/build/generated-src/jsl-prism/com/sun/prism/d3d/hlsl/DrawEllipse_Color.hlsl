float2 idim : register(c0);
float ellipsemask(float2 abstco, float2 invarcradii) {
float2 absecctco = abstco * invarcradii;
float ecclensq = dot(absecctco, absecctco);
float delta = dot(absecctco, invarcradii) * 2.0;
return clamp(0.5 + (1.0 - ecclensq) / delta, 0.0, 1.0);
}
float mask(float2 tco, float2 odim) {
float2 abstco = abs(tco);
float ocov = ellipsemask(abstco, odim);
float icov = ellipsemask(abstco, idim);
return clamp(ocov - icov, 0.0, 1.0);
}
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
color = mask(pos0, pos1) * jsl_vertexColor;
}
