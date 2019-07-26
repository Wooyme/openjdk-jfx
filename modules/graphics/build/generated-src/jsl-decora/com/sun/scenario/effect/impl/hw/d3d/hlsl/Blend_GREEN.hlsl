sampler2D botImg : register(s0);
sampler2D topImg : register(s1);
float opacity : register(c0);
float4 blend_green(float4 bot, float4 top) {
float4 res;
res.a = bot.a + top.a - (bot.a * top.a);
res.rb = bot.rb;
res.g = (1.0 - top.a) * bot.g + top.g;
return res;
}
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
float4 bot = tex2D(botImg, pos0);
float4 top = tex2D(topImg, pos1) * opacity;
color = blend_green(bot, top);
}
