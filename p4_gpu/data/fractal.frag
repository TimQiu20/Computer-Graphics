// Fragment shader

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_LIGHT_SHADER

uniform float cx;
uniform float cy;

// These values come from the vertex shader
varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;
varying vec4 vertTexCoord;

void main() {
  float zx = vertTexCoord.s * 3.0 - 1.5;
  float zy = vertTexCoord.t * 3.0 - 1.5;
  for (int i = 1; i <= 20; i++) {
  	float zxx = zx * zx - zy * zy + cx;
  	float zyy = 2 * zx * zy + cy;
  	zx = zxx;
  	zy = zyy;
  }
  if (zx * zx + zy * zy < 4*4){
  	gl_FragColor = vec4(1.0,1.0,1.0,1.0);
  } else {
  	gl_FragColor = vec4(1.0,0.0,0.0,1.0);
  }
}

