sampler2D botImg : register(s0);
sampler2D topImg : register(s1);
float opacity : register(c0);
float4 blend_hard_light(float4 bot, float4 top) {
float4 res;
res.a = bot.a + top.a - (bot.a * top.a);
float halftopa = 0.5 * top.a;
if (top.r > halftopa){
res.r = top.r + bot.a * (top.r - top.a) - bot.r * (2.0 * top.r - top.a - 1.0);
}
 else {
res.r = 2.0 * bot.r * top.r + bot.r * (1.0 - top.a) + top.r * (1.0 - bot.a);
}
if (top.g > halftopa){
res.g = top.g + bot.a * (top.g - top.a) - bot.g * (2.0 * top.g - top.a - 1.0);
}
 else {
res.g = 2.0 * bot.g * top.g + bot.g * (1.0 - top.a) + top.g * (1.0 - bot.a);
}
if (top.b > halftopa){
res.b = top.b + bot.a * (top.b - top.a) - bot.b * (2.0 * top.b - top.a - 1.0);
}
 else {
res.b = 2.0 * bot.b * top.b + bot.b * (1.0 - top.a) + top.b * (1.0 - bot.a);
}
return res;
}
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
float4 bot = tex2D(botImg, pos0);
float4 top = tex2D(topImg, pos1) * opacity;
color = blend_hard_light(bot, top);
}
