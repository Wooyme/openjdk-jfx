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
sampler2D inputTex : register(s0);
float4 xParams : register(c2);
float4 yParams : register(c3);
float3 perspVec : register(c4);
float4 content : register(c5);
float4 paint(float2 winCoord) {
float3 fragCoord = float3(winCoord.x, winCoord.y, 1.0);
float wParam = dot(fragCoord, perspVec);
float2 texCoord = float2(dot(xParams.xyz, fragCoord) / wParam + xParams.w, dot(yParams.xyz, fragCoord) / wParam + yParams.w);
texCoord = frac(texCoord);
texCoord = float2(content.x, content.y) + texCoord * float2(content.z, content.w);
return tex2D(inputTex, texCoord);
}
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
color = mask(pos0, pos1) * paint(pixcoord) * jsl_vertexColor;
if (color.a == 0.0)discard;}
