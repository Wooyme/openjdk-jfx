sampler2D bumpImg : register(s0);
sampler2D origImg : register(s1);
float diffuseConstant : register(c0);
float specularConstant : register(c1);
float specularExponent : register(c2);
float3 lightColor : register(c3);
float4 kvals[8] : register(c4);
float3 normalizedLightPosition : register(c12);
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
float4 orig = tex2D(origImg, pos1);
int i;
float3 sum = float3(0.0, 0.0, 1.0);
{
sum.xy += kvals[0].zw * tex2D(bumpImg, pos0 + kvals[0].xy).a;
}
{
sum.xy += kvals[1].zw * tex2D(bumpImg, pos0 + kvals[1].xy).a;
}
{
sum.xy += kvals[2].zw * tex2D(bumpImg, pos0 + kvals[2].xy).a;
}
{
sum.xy += kvals[3].zw * tex2D(bumpImg, pos0 + kvals[3].xy).a;
}
{
sum.xy += kvals[4].zw * tex2D(bumpImg, pos0 + kvals[4].xy).a;
}
{
sum.xy += kvals[5].zw * tex2D(bumpImg, pos0 + kvals[5].xy).a;
}
{
sum.xy += kvals[6].zw * tex2D(bumpImg, pos0 + kvals[6].xy).a;
}
{
sum.xy += kvals[7].zw * tex2D(bumpImg, pos0 + kvals[7].xy).a;
}
float3 N = normalize(sum);
float3 Lxyz = normalizedLightPosition;
float3 Lrgb = lightColor;
float3 E = float3(0.0, 0.0, 1.0);
float3 H = normalize(Lxyz + E);
float4 D;
D.rgb = diffuseConstant * dot(N, Lxyz) * Lrgb;
D.rgb = clamp(D.rgb, 0.0, 1.0);
D.a = 1.0;
float4 S;
float NdotH = dot(N, H);
S.rgb = specularConstant * pow(NdotH, specularExponent) * Lrgb;
S.a = max(S.r, S.g);
S.a = max(S.a, S.b);
orig *= D;
S *= orig.a;
color = S + (orig * (1.0 - S.a));
}
