void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;
  vec3 col = vec3(0.0);

  vec2 feedback_offset = vec2(0.0, 3.0) / iResolution.xy;

  vec3 feedback_col = texture(iChannel2, uv - feedback_offset).rgb;
  vec3 forest_col = texture(iChannel0, uv).rgb;

  vec3 sky_col = texture(iChannel1, uv).rgb;
  vec3 sky_col_hsv = rgb2hsv(sky_col);

  float feedback_amount = fract(sky_col_hsv.g * 2.0 - iBeat / 4.0);
  feedback_amount = abs(feedback_amount * 2.0 - 1.0);
  feedback_amount = step(0.5, feedback_amount);

  sky_col = hsv2rgb(vec3(sky_col_hsv.r, 1.0, sky_col_hsv.b));
  sky_col =
      mix(sky_col, max(vec3(0.0), feedback_col - 1.0 / 255.0), feedback_amount);

  float sky_mask = max(0.25, max(forest_col.r, forest_col.g) + 0.05);
  sky_mask = step(sky_mask, forest_col.b);
  sky_mask = 1.0 - step(0.1, forest_col.g);

  forest_col = hsv2rgb(vec3(length(forest_col), rgb2hsv(forest_col).gb));
  col = mix(forest_col, sky_col, sky_mask);

  fragColor = vec4(col, 1.0);
}
