sampler2D botImg : register(s0);
sampler2D topImg : register(s1);
float opacity : register(c0);
float dofx(float f, float sqrtf) {
float d;
if (f <= 0.25){
d = ((16.0 * f - 12.0) * f + 4.0) * f;
}
 else {
d = sqrtf;
}
return d;
}
float4 blend_soft_light(float4 bot, float4 top) {
float4 res;
res.a = bot.a + top.a - (bot.a * top.a);
float3 bot_np = bot.rgb / bot.a;
float3 top_np = top.rgb / top.a;
float sqrtf = sqrt(bot_np.r);
float dr = dofx(bot_np.r, sqrtf);
sqrtf = sqrt(bot_np.g);
float dg = dofx(bot_np.g, sqrtf);
sqrtf = sqrt(bot_np.b);
float db = dofx(bot_np.b, sqrtf);
if (bot.a == 0.0){
res.r = top.r;
}
 else if (top.a == 0.0){
res.r = bot.r;
}
 else if (top_np.r <= 0.5){
res.r = bot.r + (1.0 - bot.a) * top.r - top.a * bot.r * (1.0 - 2.0 * top_np.r) * (1.0 - bot_np.r);
}
 else {
res.r = bot.r + (1.0 - bot.a) * top.r + (2.0 * top.r - top.a) * (bot.a * dr - bot.r);
}
if (bot.a == 0.0){
res.g = top.g;
}
 else if (top.a == 0.0){
res.g = bot.g;
}
 else if (top_np.g <= 0.5){
res.g = bot.g + (1.0 - bot.a) * top.g - top.a * bot.g * (1.0 - 2.0 * top_np.g) * (1.0 - bot_np.g);
}
 else {
res.g = bot.g + (1.0 - bot.a) * top.g + (2.0 * top.g - top.a) * (bot.a * dg - bot.g);
}
if (bot.a == 0.0){
res.b = top.b;
}
 else if (top.a == 0.0){
res.b = bot.b;
}
 else if (top_np.b <= 0.5){
res.b = bot.b + (1.0 - bot.a) * top.b - top.a * bot.b * (1.0 - 2.0 * top_np.b) * (1.0 - bot_np.b);
}
 else {
res.b = bot.b + (1.0 - bot.a) * top.b + (2.0 * top.b - top.a) * (bot.a * db - bot.b);
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
color = blend_soft_light(bot, top);
}
