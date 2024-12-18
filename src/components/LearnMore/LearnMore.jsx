import React from 'react';
import Header from "../Header/Header";
import styles from "./LearnMore.module.css"; // CSS for styling

function LearnMore() {
  return (
    <>
      <div className={styles['learn-more-container']}> {/* Ensure correct className usage */}
      <Header />
        <section className={styles['intro-section']}>
          <h2>Welcome to Skill-It</h2>
          <p>
            Skill-It is a dynamic skill-sharing platform designed to connect
            individuals looking to upskill, improve their career prospects, and
            find better opportunities. Whether you're a freelancer searching for
            projects or an employer looking for skilled professionals, Skill-It
            is the platform where people come together to share and grow.
          </p>
        </section>

        <section className={styles['features-section']}>
          <h2>How Skill-It Works</h2>
          <p>
            Skill-It helps individuals discover job opportunities from employers
            looking for specialized talent. It's an ecosystem built for growth.
          </p>
          <p>
            Showcase your expertise and offer your services in your selected
            category. Whether it's software development, marketing, design, or any
            other skill, Skill-It is your platform.
          </p>
          <p>
            Choose from a wide range of skill categories and work fields to align
            with your expertise. Create a tailored experience based on what you do
            best!
          </p>
        </section>

        <section className={styles['categories-section']}>
          <h2>Explore Categories</h2>
          <p>
            Skill-It covers various categories where users can either learn new
            skills or find experts in these fields. Categories include:
          </p>
          <ul>
            <li>Software Development</li>
            <li>Web & Graphic Design</li>
            <li>And much more...</li>
          </ul>
        </section>

        <section className={styles['creators-section']}>
          <h2>Meet the Creators</h2>
          <p>Skill-It was created by passionate individuals striving to help others succeed:</p>
          <ul>
            <li><strong>Shashank</strong> - Founder & Developer</li>
            <li><strong>Sanath S. Shetty</strong> - Co-Founder & Designer</li>
            <li><strong>Sumanth</strong> - Lead Developer</li>
            <li><strong>Srujan</strong> - Marketing Specialist</li>
          </ul>
        </section>

        <footer className={styles['footer']}>
          <p>&copy; 2024 Skill-It - All Rights Reserved</p>
        </footer>
      </div>
    </>
  );
}

export default LearnMore;
