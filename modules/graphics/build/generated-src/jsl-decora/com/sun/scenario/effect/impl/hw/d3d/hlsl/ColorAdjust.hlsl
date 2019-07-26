sampler2D baseImg : register(s0);
float hue : register(c0);
float saturation : register(c1);
float brightness : register(c2);
float contrast : register(c3);
float3 rgb_to_hsb(float3 v) {
float h;
float s;
float b;
float cmax = max(v.r, v.g);
cmax = max(cmax, v.b);
float cmin = min(v.r, v.g);
cmin = min(cmin, v.b);
if (cmax > cmin){
float3 c = (cmax - v) / (cmax - cmin);
if (v.r == cmax){
h = c.b - c.g;
}
 else if (v.g == cmax){
h = 2.0 + c.r - c.b;
}
 else {
h = 4.0 + c.g - c.r;
}
h /= 6.0;
if (h < 0.0){
h += 1.0;
}
s = (cmax - cmin) / cmax;
}
 else {
h = 0.0;
s = 0.0;
}
b = cmax;
return float3(h, s, b);
}
float3 hsb_to_rgb(float3 v) {
float3 res = float3(0.0, 0.0, 0.0);
float h = v.r;
float s = v.g;
float b = v.b;
h = (h - floor(h)) * 6.0;
float f = h - floor(h);
float p = b * (1.0 - s);
float q = b * (1.0 - (s * f));
float t = b * (1.0 - (s * (1.0 - f)));
h = floor(h);
if (h < 1.0){
res.r = b;
res.g = t;
res.b = p;
}
 else if (h < 2.0){
res.r = q;
res.g = b;
res.b = p;
}
 else if (h < 3.0){
res.r = p;
res.g = b;
res.b = t;
}
 else if (h < 4.0){
res.r = p;
res.g = q;
res.b = b;
}
 else if (h < 5.0){
res.r = t;
res.g = p;
res.b = b;
}
 else {
res.r = b;
res.g = p;
res.b = q;
}
return res;
}
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
float4 src = tex2D(baseImg, pos0);
if (src.a > 0.0){
src.rgb /= src.a;
}
src.rgb = ((src.rgb - 0.5) * contrast) + 0.5;
float3 hsb = rgb_to_hsb(src.rgb);
hsb.r += hue;
if (hsb.r < 0.0){
hsb.r += 1.0;
}
 else if (hsb.r > 1.0){
hsb.r -= 1.0;
}
if (saturation > 1.0){
float sat = saturation - 1.0;
hsb.g += (1.0 - hsb.g) * sat;
}
 else {
hsb.g *= saturation;
}
if (brightness > 1.0){
float brt = brightness - 1.0;
hsb.g *= 1.0 - brt;
hsb.b += (1.0 - hsb.b) * brt;
}
 else {
hsb.b *= brightness;
}
hsb.gb = clamp(hsb.gb, 0.0, 1.0);
color.rgb = src.a * hsb_to_rgb(hsb);
color.a = src.a;
}
