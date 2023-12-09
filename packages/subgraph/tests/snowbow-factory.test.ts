import {
  assert,
  describe,
  test,
  clearStore,
  beforeAll,
  afterAll
} from "matchstick-as/assembly/index"
import { Address } from "@graphprotocol/graph-ts"
import { OwnershipHandoverCanceled } from "../generated/schema"
import { OwnershipHandoverCanceled as OwnershipHandoverCanceledEvent } from "../generated/SnowbowFactory/SnowbowFactory"
import { handleOwnershipHandoverCanceled } from "../src/snowbow-factory"
import { createOwnershipHandoverCanceledEvent } from "./snowbow-factory-utils"

// Tests structure (matchstick-as >=0.5.0)
// https://thegraph.com/docs/en/developer/matchstick/#tests-structure-0-5-0

describe("Describe entity assertions", () => {
  beforeAll(() => {
    let pendingOwner = Address.fromString(
      "0x0000000000000000000000000000000000000001"
    )
    let newOwnershipHandoverCanceledEvent = createOwnershipHandoverCanceledEvent(
      pendingOwner
    )
    handleOwnershipHandoverCanceled(newOwnershipHandoverCanceledEvent)
  })

  afterAll(() => {
    clearStore()
  })

  // For more test scenarios, see:
  // https://thegraph.com/docs/en/developer/matchstick/#write-a-unit-test

  test("OwnershipHandoverCanceled created and stored", () => {
    assert.entityCount("OwnershipHandoverCanceled", 1)

    // 0xa16081f360e3847006db660bae1c6d1b2e17ec2a is the default address used in newMockEvent() function
    assert.fieldEquals(
      "OwnershipHandoverCanceled",
      "0xa16081f360e3847006db660bae1c6d1b2e17ec2a-1",
      "pendingOwner",
      "0x0000000000000000000000000000000000000001"
    )

    // More assert options:
    // https://thegraph.com/docs/en/developer/matchstick/#asserts
  })
})
