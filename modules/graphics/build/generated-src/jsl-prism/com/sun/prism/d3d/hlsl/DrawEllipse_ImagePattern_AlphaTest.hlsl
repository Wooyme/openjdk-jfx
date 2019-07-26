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
sampler2D inputTex : register(s0);
float4 xParams : register(c1);
float4 yParams : register(c2);
float3 perspVec : register(c3);
float4 content : register(c4);
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
