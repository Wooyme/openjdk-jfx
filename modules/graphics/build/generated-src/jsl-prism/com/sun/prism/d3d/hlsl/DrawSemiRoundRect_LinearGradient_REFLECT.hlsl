float2 oinvarcradii : register(c0);
float2 idim : register(c1);
float rrmask(float2 abstco, float2 flatdim, float2 invarcradii) {
float2 ecctco = max(abstco - flatdim, 0.001) * invarcradii;
float ecclensq = dot(ecctco, ecctco);
float pix = dot(ecctco / ecclensq, invarcradii);
return clamp(0.5 + (1.0 + 0.25 * pix * pix - ecclensq) / (2.0 * pix), 0.0, 1.0);
}
float pgrammask(float2 abstco, float2 tcc) {
float2 cov = clamp(tcc + 0.5 - abstco, 0.0, 1.0);
cov = min(cov, tcc * 2.0);
return cov.x * cov.y;
}
float mask(float2 tco, float2 oflatdim) {
float2 abstco = abs(tco);
float ocov = rrmask(abstco, oflatdim, oinvarcradii);
float icov = pgrammask(abstco, idim);
return clamp(ocov - icov, 0.0, 1.0);
}
#define MAX_FRACTIONS (12)
#define TEXTURE_WIDTH (16.0)
#define FULL_TEXEL_X (1.0 / TEXTURE_WIDTH)
#define HALF_TEXEL_X (FULL_TEXEL_X / 2.0)
float4 fractions[12] : register(c2);
sampler2D colors : register(s0);
float offset : register(c14);
float4 sampleGradient(float dist) {
int i;
float relFraction = 0.0;
{
relFraction += clamp((dist - fractions[0].x) * fractions[0].y, 0.0, 1.0);
}
{
relFraction += clamp((dist - fractions[1].x) * fractions[1].y, 0.0, 1.0);
}
{
relFraction += clamp((dist - fractions[2].x) * fractions[2].y, 0.0, 1.0);
}
{
relFraction += clamp((dist - fractions[3].x) * fractions[3].y, 0.0, 1.0);
}
{
relFraction += clamp((dist - fractions[4].x) * fractions[4].y, 0.0, 1.0);
}
{
relFraction += clamp((dist - fractions[5].x) * fractions[5].y, 0.0, 1.0);
}
{
relFraction += clamp((dist - fractions[6].x) * fractions[6].y, 0.0, 1.0);
}
{
relFraction += clamp((dist - fractions[7].x) * fractions[7].y, 0.0, 1.0);
}
{
relFraction += clamp((dist - fractions[8].x) * fractions[8].y, 0.0, 1.0);
}
{
relFraction += clamp((dist - fractions[9].x) * fractions[9].y, 0.0, 1.0);
}
{
relFraction += clamp((dist - fractions[10].x) * fractions[10].y, 0.0, 1.0);
}
float tc = HALF_TEXEL_X + (FULL_TEXEL_X * relFraction);
return tex2D(colors, float2(tc, offset));
}
float4 cycleNone(float dist) {
if (dist <= 0.0){
return tex2D(colors, float2(0.0, offset));
}
 else if (dist >= 1.0){
return tex2D(colors, float2(1.0, offset));
}
 else {
return sampleGradient(dist);
}
}
float4 cycleReflect(float dist) {
dist = 1.0 - (abs(frac(dist * 0.5) - 0.5) * 2.0);
return sampleGradient(dist);
}
float4 cycleRepeat(float dist) {
dist = frac(dist);
return sampleGradient(dist);
}
float4 gradParams : register(c15);
float3 perspVec : register(c16);
float4 paint(float2 winCoord) {
float3 fragCoord = float3(winCoord.x, winCoord.y, 1.0);
float dist = dot(fragCoord, gradParams.xyz);
float wdist = dot(fragCoord, perspVec);
return cycleReflect(gradParams.w + dist / wdist);
}
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
color = mask(pos0, pos1) * paint(pixcoord) * jsl_vertexColor;
}
