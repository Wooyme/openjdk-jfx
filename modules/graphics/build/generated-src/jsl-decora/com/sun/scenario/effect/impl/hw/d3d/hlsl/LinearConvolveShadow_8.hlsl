sampler2D img : register(s0);
float count : register(c0);
float4 offset : register(c1);
float4 shadowColor : register(c2);
float4 weights[2] : register(c3);
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
sum = clamp(sum, 0.0, 1.0);
color = sum * shadowColor;
}
