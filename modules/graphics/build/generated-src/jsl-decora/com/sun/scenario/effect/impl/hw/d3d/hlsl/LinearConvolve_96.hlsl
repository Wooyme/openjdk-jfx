sampler2D img : register(s0);
float count : register(c0);
float4 offset : register(c1);
float4 weights[24] : register(c2);
void main(in float2 pos0 : TEXCOORD0,
in float2 pos1 : TEXCOORD1,
in float2 pixcoord : VPOS,
in float4 jsl_vertexColor : COLOR0,
out float4 color : COLOR0) {
int i;
float4 tmp = float4(0.0, 0.0, 0.0, 0.0);
float2 loc = pos0 + offset.zw;
{
tmp += weights[0].x * tex2D(img, loc);
loc += offset.xy;
tmp += weights[0].y * tex2D(img, loc);
loc += offset.xy;
tmp += weights[0].z * tex2D(img, loc);
loc += offset.xy;
tmp += weights[0].w * tex2D(img, loc);
loc += offset.xy;
}
{
tmp += weights[1].x * tex2D(img, loc);
loc += offset.xy;
tmp += weights[1].y * tex2D(img, loc);
loc += offset.xy;
tmp += weights[1].z * tex2D(img, loc);
loc += offset.xy;
tmp += weights[1].w * tex2D(img, loc);
loc += offset.xy;
}
{
tmp += weights[2].x * tex2D(img, loc);
loc += offset.xy;
tmp += weights[2].y * tex2D(img, loc);
loc += offset.xy;
tmp += weights[2].z * tex2D(img, loc);
loc += offset.xy;
tmp += weights[2].w * tex2D(img, loc);
loc += offset.xy;
}
{
tmp += weights[3].x * tex2D(img, loc);
loc += offset.xy;
tmp += weights[3].y * tex2D(img, loc);
loc += offset.xy;
tmp += weights[3].z * tex2D(img, loc);
loc += offset.xy;
tmp += weights[3].w * tex2D(img, loc);
loc += offset.xy;
}
{
tmp += weights[4].x * tex2D(img, loc);
loc += offset.xy;
tmp += weights[4].y * tex2D(img, loc);
loc += offset.xy;
tmp += weights[4].z * tex2D(img, loc);
loc += offset.xy;
tmp += weights[4].w * tex2D(img, loc);
loc += offset.xy;
}
{
tmp += weights[5].x * tex2D(img, loc);
loc += offset.xy;
tmp += weights[5].y * tex2D(img, loc);
loc += offset.xy;
tmp += weights[5].z * tex2D(img, loc);
loc += offset.xy;
tmp += weights[5].w * tex2D(img, loc);
loc += offset.xy;
}
{
tmp += weights[6].x * tex2D(img, loc);
loc += offset.xy;
tmp += weights[6].y * tex2D(img, loc);
loc += offset.xy;
tmp += weights[6].z * tex2D(img, loc);
loc += offset.xy;
tmp += weights[6].w * tex2D(img, loc);
loc += offset.xy;
}
{
tmp += weights[7].x * tex2D(img, loc);
loc += offset.xy;
tmp += weights[7].y * tex2D(img, loc);
loc += offset.xy;
tmp += weights[7].z * tex2D(img, loc);
loc += offset.xy;
tmp += weights[7].w * tex2D(img, loc);
loc += offset.xy;
}
{
tmp += weights[8].x * tex2D(img, loc);
loc += offset.xy;
tmp += weights[8].y * tex2D(img, loc);
loc += offset.xy;
tmp += weights[8].z * tex2D(img, loc);
loc += offset.xy;
tmp += weights[8].w * tex2D(img, loc);
loc += offset.xy;
}
{
tmp += weights[9].x * tex2D(img, loc);
loc += offset.xy;
tmp += weights[9].y * tex2D(img, loc);
loc += offset.xy;
tmp += weights[9].z * tex2D(img, loc);
loc += offset.xy;
tmp += weights[9].w * tex2D(img, loc);
loc += offset.xy;
}
{
tmp += weights[10].x * tex2D(img, loc);
loc += offset.xy;
tmp += weights[10].y * tex2D(img, loc);
loc += offset.xy;
tmp += weights[10].z * tex2D(img, loc);
loc += offset.xy;
tmp += weights[10].w * tex2D(img, loc);
loc += offset.xy;
}
{
tmp += weights[11].x * tex2D(img, loc);
loc += offset.xy;
tmp += weights[11].y * tex2D(img, loc);
loc += offset.xy;
tmp += weights[11].z * tex2D(img, loc);
loc += offset.xy;
tmp += weights[11].w * tex2D(img, loc);
loc += offset.xy;
}
{
tmp += weights[12].x * tex2D(img, loc);
loc += offset.xy;
tmp += weights[12].y * tex2D(img, loc);
loc += offset.xy;
tmp += weights[12].z * tex2D(img, loc);
loc += offset.xy;
tmp += weights[12].w * tex2D(img, loc);
loc += offset.xy;
}
{
tmp += weights[13].x * tex2D(img, loc);
loc += offset.xy;
tmp += weights[13].y * tex2D(img, loc);
loc += offset.xy;
tmp += weights[13].z * tex2D(img, loc);
loc += offset.xy;
tmp += weights[13].w * tex2D(img, loc);
loc += offset.xy;
}
{
tmp += weights[14].x * tex2D(img, loc);
loc += offset.xy;
tmp += weights[14].y * tex2D(img, loc);
loc += offset.xy;
tmp += weights[14].z * tex2D(img, loc);
loc += offset.xy;
tmp += weights[14].w * tex2D(img, loc);
loc += offset.xy;
}
{
tmp += weights[15].x * tex2D(img, loc);
loc += offset.xy;
tmp += weights[15].y * tex2D(img, loc);
loc += offset.xy;
tmp += weights[15].z * tex2D(img, loc);
loc += offset.xy;
tmp += weights[15].w * tex2D(img, loc);
loc += offset.xy;
}
{
tmp += weights[16].x * tex2D(img, loc);
loc += offset.xy;
tmp += weights[16].y * tex2D(img, loc);
loc += offset.xy;
tmp += weights[16].z * tex2D(img, loc);
loc += offset.xy;
tmp += weights[16].w * tex2D(img, loc);
loc += offset.xy;
}
{
tmp += weights[17].x * tex2D(img, loc);
loc += offset.xy;
tmp += weights[17].y * tex2D(img, loc);
loc += offset.xy;
tmp += weights[17].z * tex2D(img, loc);
loc += offset.xy;
tmp += weights[17].w * tex2D(img, loc);
loc += offset.xy;
}
{
tmp += weights[18].x * tex2D(img, loc);
loc += offset.xy;
tmp += weights[18].y * tex2D(img, loc);
loc += offset.xy;
tmp += weights[18].z * tex2D(img, loc);
loc += offset.xy;
tmp += weights[18].w * tex2D(img, loc);
loc += offset.xy;
}
{
tmp += weights[19].x * tex2D(img, loc);
loc += offset.xy;
tmp += weights[19].y * tex2D(img, loc);
loc += offset.xy;
tmp += weights[19].z * tex2D(img, loc);
loc += offset.xy;
tmp += weights[19].w * tex2D(img, loc);
loc += offset.xy;
}
{
tmp += weights[20].x * tex2D(img, loc);
loc += offset.xy;
tmp += weights[20].y * tex2D(img, loc);
loc += offset.xy;
tmp += weights[20].z * tex2D(img, loc);
loc += offset.xy;
tmp += weights[20].w * tex2D(img, loc);
loc += offset.xy;
}
{
tmp += weights[21].x * tex2D(img, loc);
loc += offset.xy;
tmp += weights[21].y * tex2D(img, loc);
loc += offset.xy;
tmp += weights[21].z * tex2D(img, loc);
loc += offset.xy;
tmp += weights[21].w * tex2D(img, loc);
loc += offset.xy;
}
{
tmp += weights[22].x * tex2D(img, loc);
loc += offset.xy;
tmp += weights[22].y * tex2D(img, loc);
loc += offset.xy;
tmp += weights[22].z * tex2D(img, loc);
loc += offset.xy;
tmp += weights[22].w * tex2D(img, loc);
loc += offset.xy;
}
{
tmp += weights[23].x * tex2D(img, loc);
loc += offset.xy;
tmp += weights[23].y * tex2D(img, loc);
loc += offset.xy;
tmp += weights[23].z * tex2D(img, loc);
loc += offset.xy;
tmp += weights[23].w * tex2D(img, loc);
loc += offset.xy;
}
color = tmp;
}
