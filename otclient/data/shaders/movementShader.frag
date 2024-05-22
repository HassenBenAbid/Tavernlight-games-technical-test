#version 130

in vec2 v_texCoord;
out vec4 fragColor;

uniform float time;
uniform vec2 resolution;

void main() {
    vec2 uv = v_texCoord;
    vec2 pos = gl_FragCoord.xy / resolution.xy;

    float distance = length(uv - vec2(0.5, 0.5));
    float effect = sin(distance * 10.0 - time * 5.0) * 0.5 + 0.5;

    fragColor = vec4(effect, effect, 1.0, 1.0);
}