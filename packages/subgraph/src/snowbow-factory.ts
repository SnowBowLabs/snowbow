import { SnowbowProduct } from "../generated/templates";
import { ProductCreate } from "../generated/SnowbowFactory/SnowbowFactory";

export function handleProductCreate(event: ProductCreate): void {
  SnowbowProduct.create(event.params.param0);
}
