
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;
  vec3 col = vec3(0.0);

  vec3 forest_col = texture(iChannel0, uv).rgb;
  vec3 butterfly_col = texture(iChannel1, uv).rgb;
  float sky_threshold = max(0.25, max(forest_col.r, forest_col.g) + 0.05);
  col = mix(forest_col, butterfly_col, step(sky_threshold, forest_col.b));
  fragColor = vec4(col, 1.0);
}
