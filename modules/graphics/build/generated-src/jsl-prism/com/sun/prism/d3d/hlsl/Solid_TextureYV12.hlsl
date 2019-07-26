sampler2D lumaTex : register(s0);
sampler2D crTex : register(s1);
sampler2D cbTex : register(s2);
sampler2D alphaTex : register(s3);
float4 lumaAlphaScale : register(c0);
float4 cbCrScale : register(c1);
#define Y_ADJUST (16.0 / 255.0)
float4 paint(float2 texCoord) {
float2 imgCoord;
float luma = 1.1644 * (tex2D(lumaTex, texCoord * lumaAlphaScale.xy).a - Y_ADJUST);
float cb = tex2D(cbTex, texCoord * cbCrScale.xy).a - 0.5;
float cr = tex2D(crTex, texCoord * cbCrScale.zw).a - 0.5;
float4 RGBA;
RGBA.r = luma + (1.5966 * cr);
RGBA.g = luma - (0.392 * cb) - (0.8132 * cr);
RGBA.b = luma + (2.0184 * cb);
if (lumaAlphaScale.z > 0.0){
RGBA.a = tex2D(alphaTex, texCoord * lumaAlphaScale.zw).a;
RGBA.rgb *= RGBA.a;
}
 else {
RGBA.a = 1.0;
}
return RGBA;
}
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
color = paint(pos0) * jsl_vertexColor;
}
