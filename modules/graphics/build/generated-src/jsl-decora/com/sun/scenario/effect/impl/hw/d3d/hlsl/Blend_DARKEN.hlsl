sampler2D botImg : register(s0);
sampler2D topImg : register(s1);
float opacity : register(c0);
float4 blend_darken(float4 bot, float4 top) {
float4 res;
res.a = bot.a + top.a - (bot.a * top.a);
res.rgb = bot.rgb + top.rgb - max(top.a * bot.rgb, bot.a * top.rgb);
return res;
}
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
float4 bot = tex2D(botImg, pos0);
float4 top = tex2D(topImg, pos1) * opacity;
color = blend_darken(bot, top);
}
