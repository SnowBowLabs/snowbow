import { SnowbowProduct } from "../generated/templates";
import { ProductCreate } from "../generated/SnowbowFactory/SnowbowFactory";
import { fetchProduct } from "./snowbow-product";

export function handleProductCreate(event: ProductCreate): void {
  fetchProduct(event.params.param0);
  SnowbowProduct.create(event.params.param0);
}
