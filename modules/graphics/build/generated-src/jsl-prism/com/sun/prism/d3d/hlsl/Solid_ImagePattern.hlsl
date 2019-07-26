sampler2D inputTex : register(s0);
float4 xParams : register(c0);
float4 yParams : register(c1);
float3 perspVec : register(c2);
float4 content : register(c3);
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
color = paint(pixcoord) * jsl_vertexColor;
}
