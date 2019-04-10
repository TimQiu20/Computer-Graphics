// Fragment shader

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXLIGHT_SHADER

// Set in Processing
uniform sampler2D texture;

// These values come from the vertex shader
varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;
varying vec4 vertTexCoord;


void main() { 
  vec4 diffuse_color = texture2D(texture, vertTexCoord.xy);
  float diffuse = clamp(dot (vertNormal, vertLightDir),0.0,1.0);
  gl_FragColor = vec4(diffuse * diffuse_color.rgb, 1.0);
  float red = 0.0;
  float green = 0.0;
  float blue = 0.0;
  for (int i = -10; i < 11; i++) {
    for (int j = -10; j < 11; j++) {
      float n = i / float(256);
      float m = j / float(256);
      red += texture2D(texture, vertTexCoord.xy + vec2(n, m)).r;
      green += texture2D(texture, vertTexCoord.xy + vec2(n, m)).g;
      blue += texture2D(texture, vertTexCoord.xy + vec2(n, m)).b;
    }
  }
  gl_FragColor = vec4(vec3(red,green,blue)/400.0,1.0);
}

