// Fragment shader

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_LIGHT_SHADER

// These values come from the vertex shader
varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;
varying vec4 vertTexCoord;

void main() {
  gl_FragColor = vec4(0, 1.0, 1.0, 0.0);
  float R = 0.1;
  float RR = 0.13;
  if (distance(vertTexCoord,vec4(0.5,0.3,0,0)) > R && distance(vertTexCoord,vec4(0.5,0.3,0,0)) < RR){
  	gl_FragColor = vec4(0.0, 1.0, 1.0, 1);
  }
  if (distance(vertTexCoord,vec4(0.23,0.3,0,0)) > R && distance(vertTexCoord,vec4(0.23,0.3,0,0)) < RR){
  	gl_FragColor = vec4(0.0, 1.0, 1.0, 1);
  }
  if (distance(vertTexCoord,vec4(0.365,0.43,0,0)) > R && distance(vertTexCoord,vec4(0.365,0.43,0,0)) < RR){
  	gl_FragColor = vec4(0.0, 1.0, 1.0, 1);
  }
  if (distance(vertTexCoord,vec4(0.77,0.3,0,0)) > R && distance(vertTexCoord,vec4(0.77,0.3,0,0)) < RR){
  	gl_FragColor = vec4(0.0, 1.0, 1.0, 1);
  }  
  if (distance(vertTexCoord,vec4(0.635,0.43,0,0)) > R && distance(vertTexCoord,vec4(0.635,0.43,0,0)) < RR){
  	gl_FragColor = vec4(0.0, 1.0, 1.0, 1);
  }
}

