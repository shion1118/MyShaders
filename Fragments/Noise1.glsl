#version 150

uniform float time;
uniform vec2 resolution;

out vec4 fragColor;

float random (float x) {
    return fract(sin(x)*1e4);
}

float random (vec2 st) { 
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

float pattern(vec2 st, vec2 v) {
    vec2 p = floor(st+v);
    return step(0.5, random(100.+p*.000001) + random(p.x)*0.5);
}

void main(void)
{
    vec2 st = gl_FragCoord.xy/resolution.xy;
    st.x *= resolution.x/resolution.y;

    vec2 grid = vec2(100.0,50.0);
    st *= grid;
    
    vec2 ipos = floor(st);
    vec2 fpos = fract(st);

    vec2 vel = vec2((time+500)*100);
    vel *= vec2(-0.6,0.0) * random(1.0+ipos.y);

    vec2 offset = vec2(0.2,0.);

    vec3 color = vec3(0.);
    color.r = pattern(st,vel);
    color.g = pattern(st,vel);
    color.b = pattern(st,vel);

    color *= step(0.2,fpos.y);

    fragColor = vec4(1.0-color,1.0);
}
