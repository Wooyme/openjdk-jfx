sampler2D botImg : register(s0);
sampler2D topImg : register(s1);
float opacity : register(c0);
float4 blend_overlay(float4 bot, float4 top) {
float4 res;
res.a = bot.a + top.a - bot.a * top.a;
float3 mask = ceil(bot.rgb - bot.a * 0.5);
float3 adjbot = abs(bot.rgb - mask * bot.a);
float3 adjtop = abs(top.rgb - mask * top.a);
res.rgb = (2.0 * adjbot + 1.0 - bot.a) * adjtop + (1.0 - top.a) * adjbot;
res.rgb = abs(res.rgb - mask * res.a);
return res;
}
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
float4 bot = tex2D(botImg, pos0);
float4 top = tex2D(topImg, pos1) * opacity;
color = blend_overlay(bot, top);
}
