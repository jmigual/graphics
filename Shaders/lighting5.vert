#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelMatrix;
uniform mat4 viewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 modelViewProjectionMatrix;

uniform mat4 modelMatrixInverse;
uniform mat4 viewMatrixInverse;
uniform mat4 projectionMatrixInverse;
uniform mat4 modelViewMatrixInverse;
uniform mat4 modelViewProjectionMatrixInverse;

uniform mat3 normalMatrix;

uniform vec4 lightPosition; // similar a gl_LightSource[0].position; en eye space
uniform bool world;

out vec3 N;
out vec3 L;
out vec3 V;

void main()
{
    if (world) {
      vec3 P = vertex;
      N = normal;
      L = (viewMatrixInverse*lightPosition).xyz - P; 
      V = (viewMatrixInverse*vec4(0,0,0,1)).xyz - P;
    }
    else {
      vec3 P = (modelViewMatrix*vec4(vertex, 1.0)).xyz;
      N = normalMatrix * normal;
      L = lightPosition.xyz - P; 
      V = -P;
    }
    
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(vertex.xyz, 1.0);
}

