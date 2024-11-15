defmodule GildedRose do
  def update_item(%{name: "Aged Brie"} = item), do: update_aged_brie(item)
  def update_item(%{name: "Backstage passes to a TAFKAL80ETC concert"} = item), do: increment_backstage_quality(item)
  def update_item(%{name: "Sulfuras, Hand of Ragnaros"} = item), do: item
  def update_item(%{name: "Conjured"} = item), do: update_conjured_item(item)
  def update_item(item), do: update_normal_item(item)

  defp update_aged_brie(%{quality: quality, sell_in: sell_in} = item) when sell_in <= 0, do: %{item | quality: min(50, quality + 2), sell_in: sell_in - 1}
  defp update_aged_brie(%{quality: quality, sell_in: sell_in} = item) when sell_in > 0, do: %{item | quality: min(50, quality + 1), sell_in: sell_in - 1}

  defp increment_backstage_quality(%{sell_in: _sell_in, quality: _quality} = item) when item.sell_in <= 0, do: %{item | quality: 0, sell_in: item.sell_in - 1}
  defp increment_backstage_quality(%{sell_in: _sell_in, quality: _quality} = item) when item.sell_in <= 5, do: update_backstage_quality(item, 3)
  defp increment_backstage_quality(%{sell_in: _sell_in, quality: _quality} = item) when item.sell_in <= 10, do: update_backstage_quality(item, 2)
  defp increment_backstage_quality(%{sell_in: _sell_in, quality: _quality} = item), do: update_backstage_quality(item, 1)

  defp update_backstage_quality(item, increment) do
    new_quality = min(50, item.quality + increment)
    %{item | quality: new_quality, sell_in: item.sell_in - 1}
  end

  defp update_conjured_item(%{quality: quality, sell_in: sell_in} = item) when quality > 1 do
    new_quality = max(0, quality - 2)
    %{item | quality: new_quality, sell_in: sell_in - 1}
  end

  defp update_conjured_item(%{quality: _quality, sell_in: _sell_in} = item), do: %{item | quality: 0, sell_in: item.sell_in - 1}

  defp update_normal_item(%{quality: quality, sell_in: sell_in} = item) when quality > 0 do
    new_quality = max(0, quality - 1)
    %{item | quality: new_quality, sell_in: sell_in - 1}
  end

  defp update_normal_item(%{quality: 0, sell_in: sell_in} = item), do: %{item | sell_in: sell_in - 1}
end