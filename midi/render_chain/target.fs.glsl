
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;

  vec3 color = uv.xyy;

  float value = 0.0;

  if (uv.y < 1.0 / 3.0) {
    value = texelFetch(iChannel0, ivec2(int(uv.x * 255.0), 0.0), 0).r;
  } else if (uv.y < 2.0 / 3.0) {
    value = texelFetch(iChannel1, ivec2(int(uv.x * 255.0), 0.0), 0).r;
  } else if (uv.y < 3.0 / 3.0) {
    value = texelFetch(iChannel2, ivec2(int(uv.x * 255.0), 0.0), 0).r;
    value = 1.0 - step(value, 1.0 - (1.0 - uv.y) * 3.0);
  }

  color = vec3(value);

  fragColor = vec4(color, 1.0);
}
