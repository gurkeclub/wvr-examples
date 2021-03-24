
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;
  vec3 col = vec3(0.0);

  vec2 back_buffer_offset = vec2(0.0, 3.0) / iResolution.xy;
  vec2 butterfly_offset =
      vec2(rand(vec2(fract(iBeat), fract(iBeat * 2.0))),
           rand(vec2(fract(iBeat * 4.0), fract(iBeat * 8.0)))) *
      4.0 / iResolution.xy;

  vec3 back_buffer_col = texture(iChannel2, uv - back_buffer_offset).rgb;
  vec3 forest_col = texture(iChannel0, uv).rgb;

  vec3 butterfly_col = texture(iChannel1, uv - butterfly_offset).rgb;
  vec3 butterfly_col_hsv = rgb2hsv(butterfly_col);
  butterfly_col =
      mix(hsv2rgb(vec3(butterfly_col_hsv.r, 1.0, butterfly_col_hsv.b)),
          max(vec3(0.0), back_buffer_col - 1.0 / 255.0),
          1.0 - step(0.8, butterfly_col_hsv.g));

  float sky_threshold = max(0.25, max(forest_col.r, forest_col.g) + 0.05);

  col = mix(hsv2rgb(vec3(length(forest_col), rgb2hsv(forest_col).gb)),
            butterfly_col, step(sky_threshold, forest_col.b));

  fragColor = vec4(col, 1.0);
}
