describe("Product Details", () => {
  it("Visit the home page", () => {
    cy.visit('/');
  });

  it("Click the scented blade product on the home page", () => {
    cy.get('img[alt="Scented Blade"]').click();
  });

  it("The redirected page contains decription for Scented Blade product", () => {
    cy.contains('The Scented Blade is an extremely rare, tall plant and can be found mostly in savannas. It blooms once a year, for 2 weeks.');
  });

});