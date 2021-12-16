module Color
  COLORS = %w[Red Blue Green Yellow Magenta Cyan White Black].freeze

  def four_random_colors
    Array.new(4) { COLORS.sample }
  end
end
