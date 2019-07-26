float2 oinvarcradii : register(c0);
float2 iinvarcradii : register(c1);
float rrmask(float2 arcreltco, float2 invarcradii) {
float2 ecctco = arcreltco * invarcradii;
float ecclensq = dot(ecctco, ecctco);
float pix = dot(ecctco / ecclensq, invarcradii);
return clamp(0.5 + (1.0 - ecclensq) / (2.0 * pix), 0.0, 1.0);
}
float mask(float2 tco, float2 flatdim) {
float2 arcreltco = max(abs(tco) - flatdim, 0.001);
float ocov = rrmask(arcreltco, oinvarcradii);
float icov = rrmask(arcreltco, iinvarcradii);
return clamp(ocov - icov, 0.0, 1.0);
}
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
color = mask(pos0, pos1) * jsl_vertexColor;
if (color.a == 0.0)discard;}
