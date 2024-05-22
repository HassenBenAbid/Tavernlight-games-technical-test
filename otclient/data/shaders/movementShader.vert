#version 130

in vec3 position;
in vec2 texCoord;

out vec2 v_texCoord;

uniform mat4 u_projectionMatrix;
uniform mat4 u_modelViewMatrix;

void main() {
    gl_Position = u_projectionMatrix * u_modelViewMatrix * vec4(position, 1.0);
    v_texCoord  = texCoord;
}