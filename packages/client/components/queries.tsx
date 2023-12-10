import { gql } from '@apollo/client';

export const GET_USER_PORTFOLIO = gql`
  query GetUserPortfolio($id: ID!) {
    user(id: $id) {
      portfolio {
        id
        product {
          id
          targetToken
        }
        holdingTargetAmount
      }
    }
  }
`;


