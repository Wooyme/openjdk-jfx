sampler2D dstColor : register(s0);
sampler2D glyphColor : register(s1);
float3 gamma : register(c0);
float4 paint(float2 texCoord, float2 texCoord2, float4 jslVertexColor) {
float unitXCoord = gamma.z;
float2 dTexCoord = texCoord;
float4 glyphClr;
dTexCoord.x = texCoord.x - unitXCoord;
glyphClr.r = tex2D(glyphColor, dTexCoord).a;
glyphClr.g = tex2D(glyphColor, texCoord).a;
dTexCoord.x = texCoord.x + unitXCoord;
glyphClr.b = tex2D(glyphColor, dTexCoord).a;
#define third (1.0 / 3.0)
glyphClr.a = dot(glyphClr.rgb, float3(third, third, third));
if (glyphClr.a == 0.0){
discard;}
float4 dstClr = tex2D(dstColor, texCoord2);
dstClr = pow(dstClr, float4(gamma.y, gamma.y, gamma.y, gamma.y));
float4 c = jslVertexColor;
float4 glyphMix;
glyphMix.a = glyphClr.a;
glyphMix.rgb = lerp(float3(glyphClr.a, glyphClr.a, glyphClr.a), glyphClr.rgb, dstClr.a);
c = dstClr * (1.0 - glyphClr * c.a) + c * glyphMix;
c = pow(c, float4(gamma.x, gamma.x, gamma.x, gamma.x));
return c;
}
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
color = paint(pos0, pos1, jsl_vertexColor);
}
