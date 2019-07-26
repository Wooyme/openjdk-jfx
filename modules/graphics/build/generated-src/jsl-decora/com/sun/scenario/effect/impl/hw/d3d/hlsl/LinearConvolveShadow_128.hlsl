sampler2D img : register(s0);
float count : register(c0);
float4 offset : register(c1);
float4 shadowColor : register(c2);
float4 weights[32] : register(c3);
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
int i;
float sum = 0.0;
float2 loc = pos0 + offset.zw;
{
sum += weights[0].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[0].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[0].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[0].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[1].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[1].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[1].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[1].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[2].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[2].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[2].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[2].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[3].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[3].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[3].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[3].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[4].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[4].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[4].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[4].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[5].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[5].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[5].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[5].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[6].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[6].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[6].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[6].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[7].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[7].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[7].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[7].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[8].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[8].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[8].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[8].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[9].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[9].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[9].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[9].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[10].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[10].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[10].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[10].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[11].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[11].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[11].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[11].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[12].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[12].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[12].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[12].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[13].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[13].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[13].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[13].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[14].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[14].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[14].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[14].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[15].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[15].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[15].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[15].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[16].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[16].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[16].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[16].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[17].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[17].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[17].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[17].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[18].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[18].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[18].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[18].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[19].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[19].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[19].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[19].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[20].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[20].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[20].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[20].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[21].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[21].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[21].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[21].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[22].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[22].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[22].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[22].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[23].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[23].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[23].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[23].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[24].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[24].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[24].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[24].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[25].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[25].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[25].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[25].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[26].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[26].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[26].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[26].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[27].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[27].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[27].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[27].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[28].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[28].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[28].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[28].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[29].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[29].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[29].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[29].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[30].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[30].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[30].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[30].w * tex2D(img, loc).a;
loc += offset.xy;
}
{
sum += weights[31].x * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[31].y * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[31].z * tex2D(img, loc).a;
loc += offset.xy;
sum += weights[31].w * tex2D(img, loc).a;
loc += offset.xy;
}
sum = clamp(sum, 0.0, 1.0);
color = sum * shadowColor;
}
