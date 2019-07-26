sampler2D botImg : register(s0);
sampler2D topImg : register(s1);
float opacity : register(c0);
float4 blend_color_burn(float4 bot, float4 top) {
float4 res;
res.a = bot.a + top.a - (bot.a * top.a);
res.rgb = (1.0 - top.a) * bot.rgb + (1.0 - bot.a) * top.rgb;
float proda = bot.a * top.a;
float topa2 = top.a * top.a;
float3 tmp;
if (bot.a == bot.r){
tmp.r = proda;
}
 else if (top.r == 0.0){
tmp.r = 0.0;
}
 else {
tmp.r = topa2 * (bot.a - bot.r) / top.r;
if (tmp.r >= proda){
tmp.r = 0.0;
}
 else {
tmp.r = proda - tmp.r;
}
}
if (bot.a == bot.g){
tmp.g = proda;
}
 else if (top.g == 0.0){
tmp.g = 0.0;
}
 else {
tmp.g = topa2 * (bot.a - bot.g) / top.g;
if (tmp.g >= proda){
tmp.g = 0.0;
}
 else {
tmp.g = proda - tmp.g;
}
}
if (bot.a == bot.b){
tmp.b = proda;
}
 else if (top.b == 0.0){
tmp.b = 0.0;
}
 else {
tmp.b = topa2 * (bot.a - bot.b) / top.b;
if (tmp.b >= proda){
tmp.b = 0.0;
}
 else {
tmp.b = proda - tmp.b;
}
}
res.rgb = res.rgb + tmp;
return res;
}
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
float4 bot = tex2D(botImg, pos0);
float4 top = tex2D(topImg, pos1) * opacity;
color = blend_color_burn(bot, top);
}
