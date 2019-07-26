sampler2D baseImg : register(s0);
float level : register(c0);
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
float3 weightBW = float3(0.3, 0.59, 0.11);
float3 weightSep = float3(1.6, 1.2, 0.9);
float4 srcClr = tex2D(baseImg, pos0);
float l = dot(srcClr.rgb, weightBW);
float3 lum = float3(l, l, l);
float3 sep = lum * weightSep;
color.rgb = lerp(sep, srcClr.rgb, 1.0 - level);
color.a = srcClr.a;
}
