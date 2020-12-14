#version 140

uniform sampler2D bb_0;

uniform sampler2D tex;
in vec2 v_tex_coords;
out vec4 f_color;

void main() {
  vec3 color = texture(bb_0, v_tex_coords.xy).rgb;
  f_color = vec4(color, 1.0);
}
