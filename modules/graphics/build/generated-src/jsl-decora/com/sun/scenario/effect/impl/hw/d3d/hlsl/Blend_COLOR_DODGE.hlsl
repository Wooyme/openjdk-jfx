sampler2D botImg : register(s0);
sampler2D topImg : register(s1);
float opacity : register(c0);
float4 blend_color_dodge(float4 bot, float4 top) {
float4 res;
res.a = bot.a + top.a - (bot.a * top.a);
res.rgb = (1.0 - top.a) * bot.rgb + (1.0 - bot.a) * top.rgb;
float proda = bot.a * top.a;
float3 tmp;
if (bot.r == 0.0){
tmp.r = 0.0;
}
 else if (top.a == top.r){
tmp.r = proda;
}
 else {
tmp.r = top.a * top.a * bot.r / (top.a - top.r);
if (tmp.r > proda){
tmp.r = proda;
}
}
if (bot.g == 0.0){
tmp.g = 0.0;
}
 else if (top.a == top.g){
tmp.g = proda;
}
 else {
tmp.g = top.a * top.a * bot.g / (top.a - top.g);
if (tmp.g > proda){
tmp.g = proda;
}
}
if (bot.b == 0.0){
tmp.b = 0.0;
}
 else if (top.a == top.b){
tmp.b = proda;
}
 else {
tmp.b = top.a * top.a * bot.b / (top.a - top.b);
if (tmp.b > proda){
tmp.b = proda;
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
color = blend_color_dodge(bot, top);
}
